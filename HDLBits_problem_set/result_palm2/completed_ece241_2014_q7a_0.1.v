module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    // Insert your code below
    
    count4 the_counter (clk, c_enable, c_load, c_d /*, ... */ );

    // The following logic gates implement the synchronous counter.
    
    // The counter state is stored in the D flip-flops D0-D3.
    
    D flip-flop D0 (clk, reset, enable, Q[0]);
    D flip-flop D1 (clk, reset, enable, Q[1]);
    D flip-flop D2 (clk, reset, enable, Q[2]);
    D flip-flop D3 (clk, reset, enable, Q[3]);

    // The output of the counter is Q[3:0].
    
    assign Q = [Q[3], Q[2], Q[1], Q[0]];

endmodule