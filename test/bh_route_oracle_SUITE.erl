-module(bh_route_oracle_SUITE).
-compile([nowarn_export_all, export_all]).

-include("ct_utils.hrl").

all() -> [
          price_test,
          list_test
         ].

init_per_suite(Config) ->
    ?init_bh(Config).

end_per_suite(Config) ->
    ?end_bh(Config).

price_test(_Config) ->
    {ok, {_, _, Json}} = ?json_request("/v1/oracle/prices/current"),
    ?assertMatch(#{ <<"data">> :=
                        #{ <<"block">> :=  _,
                           <<"price">> := _
                         }
                  }, Json),

    ok.

list_test(_Config) ->
    {ok, {_, _, Json}} = ?json_request("/v1/oracle/prices"),
    #{ <<"data">> := Data } = Json,
    ?assert(length(Data) >= 0),

    ok.
