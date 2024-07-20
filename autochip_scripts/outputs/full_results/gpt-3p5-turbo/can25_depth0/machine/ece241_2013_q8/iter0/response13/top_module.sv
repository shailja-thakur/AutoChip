module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // define states
    localparam S = 2'b00;
    localparam S1 = 2'b01;
    localparam S10 = 2'b10;
    
    // define next state logic
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            // reset to initial state S
            z <= 1'b0;
        end else begin
            case ({x, z})
                2'b00: z <= 1'b0; // input x=0, state S, next state S
                2'b01: z <= 1'b0; // input x=0, state S1, next state S1
                2'b10: z <= x;    // input x=1, state S10, next state S1
                2'b11: z <= 1'b0; // input x=1, state S10, next state S10
                default: z <= 1'b0; // default case
            endcase
        end
    end
endmodule
