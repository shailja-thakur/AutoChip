module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // The first assign statement assigns values to the next_state[A] port.
    // This port depends on the state[A] and state[C] ports and the in port.
    // If the in port is low then the port is assigned to the ORed value of state[A] and state[C].
    // If the in port is high the port is assigned to zero.
    assign next_state[0] = (~in) ? (state[0] | state[2]) : 1'b0;

    // The second assign statement assigns values to the next_state[B] port.
    // This port depends on the state[A], state[B] and state[D] ports and the in port.
    // If the in port is low then the port is assigned to zero.
    // If the in port is high then the port is assigned to the ORed value of the state[A], state[B], and state[D] ports.
    assign next_state[1] = (in) ? (state[0] | state[1] | state[3]) : 1'b0;

    // The third assign statement assigns values to the next_state[C] port.
    // This port depends on the state[B] and state[D] ports and the in port.
    // If the in port is low then the port is assigned to the ORed value of the state[B] and state[D] ports.
    // If the in port is high the port is assigned to zero.
    assign next_state[2] = (~in) ? (state[1] | state[3]) : 1'b0;

    // The forth assign statement assigns values to the next_state[D] port.
    // This port depends on the state[C] port and the in port.
    // If the in port is low then the port is assigned to zero.
    // If the in port is high then the port is assigned to the state[C] port.
    assign next_state[3] = (in) ? state[2] : 1'b0;

    // The out port depends on the state[D] port.
    // The out port is assigned to the value of the state[D] port.
    assign out = state[3];

endmodule
