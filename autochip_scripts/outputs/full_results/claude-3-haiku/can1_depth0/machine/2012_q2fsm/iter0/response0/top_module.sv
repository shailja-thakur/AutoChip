module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the state register
reg [2:0] state;

// Define the states
parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: state <= (w) ? B : A;
            B: state <= (w) ? C : D;
            C: state <= (w) ? E : D;
            D: state <= (w) ? F : A;
            E: state <= (w) ? E : D;
            F: state <= (w) ? C : D;
        endcase
    end
end

// Assign the output z
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
