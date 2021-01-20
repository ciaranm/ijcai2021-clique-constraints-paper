/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#ifndef GLASGOW_SUBGRAPH_SOLVER_GUARD_SRC_PROOF_HH
#define GLASGOW_SUBGRAPH_SOLVER_GUARD_SRC_PROOF_HH 1

#include "proof-fwd.hh"

#include <exception>
#include <functional>
#include <iosfwd>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <tuple>
#include <vector>

class ProofError : public std::exception
{
    private:
        std::string _message;

    public:
        ProofError(const std::string & message) noexcept;

        virtual auto what() const noexcept -> const char *;
};

using NamedVertex = std::pair<int, std::string>;

class Proof
{
    private:
        struct Imp;
        std::unique_ptr<Imp> _imp;

    public:
        Proof(const std::string & opb_file, const std::string & log_file, bool friendly_names, bool bz2);
        Proof(Proof &&);
        ~Proof();
        auto operator= (Proof &&) -> Proof &;

        Proof(const Proof &) = delete;
        auto operator= (const Proof &) -> Proof & = delete;

        // model-writing functions
        auto create_cp_variable(int pattern_vertex, int target_size,
                const std::function<auto (int) -> std::string> & pattern_name,
                const std::function<auto (int) -> std::string> & target_name) -> void;

        auto create_injectivity_constraints(int pattern_size, int target_size) -> void;
        auto create_forbidden_assignment_constraint(int p, int t) -> void;
        auto start_adjacency_constraints_for(int p, int t) -> void;
        auto create_adjacency_constraint(int p, int q, int t, const std::vector<int> & u) -> void;

        auto finalise_model() -> void;

        // when we're done
        auto finish_unsat_proof() -> void;

        // top of search failures
        auto failure_due_to_pattern_bigger_than_target() -> void;

        // domain initialisation
        auto incompatible_by_degrees(
                int g,
                const NamedVertex & p,
                const std::vector<int> & n_p,
                const NamedVertex & t,
                const std::vector<int> & n_t) -> void;

        auto incompatible_by_nds(
                int g,
                const NamedVertex & p,
                const NamedVertex & t,
                const std::vector<int> & p_subsequence,
                const std::vector<int> & t_subsequence,
                const std::vector<int> & t_remaining) -> void;

        auto initial_domain_is_empty(int p) -> void;

        // distance 2 graphs
        auto create_exact_path_graphs(
                int g,
                const NamedVertex & p,
                const NamedVertex & q,
                const std::vector<NamedVertex> & between_p_and_q,
                const NamedVertex & t,
                const std::vector<NamedVertex> & n_t,
                const std::vector<std::pair<NamedVertex, std::vector<NamedVertex> > > & two_away_from_t,
                const std::vector<NamedVertex> & d_n_t
                ) -> void;

        // new constraints
        auto emit_hall_set_or_violator(const std::vector<int> & lhs, const std::vector<int> & rhs) -> void;

        // branch logging
        auto root_propagation_failed() -> void;
        auto guessing(int depth, const NamedVertex & branch_v, const NamedVertex & val) -> void;
        auto propagation_failure(const std::vector<std::pair<int, int> > & decisions, const NamedVertex & branch_v, const NamedVertex & val) -> void;
        auto incorrect_guess(const std::vector<std::pair<int, int> > & decisions, bool was_failure) -> void;
        auto out_of_guesses(const std::vector<std::pair<int, int> > & decisions) -> void;
        auto unit_propagating(const NamedVertex & var, const NamedVertex & val) -> void;

        // proof levels
        auto start_level(int level) -> void;
        auto back_up_to_level(int level) -> void;
        auto forget_level(int level) -> void;
        auto back_up_to_top() -> void;
        auto post_restart_nogood(const std::vector<std::pair<int, int> > & decisions) -> void;

        // cliques
        auto create_binary_variable(int vertex,
                const std::function<auto (int) -> std::string> & name) -> void;
        auto create_objective(int n, std::optional<int> d) -> void;
        auto create_non_edge_constraint(int p, int q) -> void;
        auto backtrack_from_binary_variables(const std::vector<int> &) -> void;
        auto colour_bound(const std::vector<std::vector<int> > &) -> void;

        // clique for hom
        auto prepare_hom_clique_proof(const NamedVertex & p,
                const NamedVertex & t,
                unsigned size) -> void;

        auto start_hom_clique_proof(const NamedVertex & p,
                std::vector<NamedVertex> && p_clique_neighbourhood,
                const NamedVertex & t,
                std::map<int, NamedVertex> && t_clique_neighbourhood) -> void;

        auto finish_hom_clique_proof(const NamedVertex & p, const NamedVertex & t, unsigned size) -> void;

        auto add_hom_clique_non_edge(
                const NamedVertex & filter_p,
                const NamedVertex & filter_t,
                const std::vector<NamedVertex> & p_clique,
                const NamedVertex & t,
                const NamedVertex & u) -> void;

        // common subgraphs
        auto create_non_null_decision_bound(int p, int t, std::optional<int> d) -> void;
        auto rewrite_mcs_objective(int pattern_size) -> void;
        auto mcs_bound(
                const std::vector<std::pair<std::set<int>, std::set<int> > > & partitions) -> void;
        auto create_connected_constraints(int p, int t, const std::function<auto (int, int) -> bool> & adj) -> void;

        // common subgraph to clique
        auto has_clique_model() const -> bool;
        auto create_clique_encoding(const std::vector<std::pair<int, int> > &) -> void;
        auto create_clique_nonedge(int v, int w) -> void;
        auto not_connected_in_underlying_graph(const std::vector<int> &, int) -> void;

        // enumeration
        auto post_solution(const std::vector<std::pair<NamedVertex, NamedVertex> > & decisions) -> void;
        auto post_solution(const std::vector<int> & solution) -> void;

        // optimisation
        auto new_incumbent(const std::vector<std::pair<int, bool> > & solution) -> void;
        auto new_incumbent(const std::vector<std::tuple<NamedVertex, NamedVertex, bool> > & solution) -> void;
};

#endif
