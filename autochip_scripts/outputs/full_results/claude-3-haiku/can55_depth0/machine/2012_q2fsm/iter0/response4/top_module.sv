module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    // State register
    reg [2:0] state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: state <= w ? B : A;
                B: state <= w ? C : D;
                C: state <= w ? E : D;
                D: state <= w ? F : A;
                E: state <= w ? E : D;
                F: state <= w ? C : D;
            endcase
        end
    end

    // Output logic
    assign z = (state == E) | (state == F);

endmodule
