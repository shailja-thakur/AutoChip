module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State register
reg [2:0] state;

// State definitions
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;
localparam E = 3'b100;
localparam F = 3'b101;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
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

// Output logic
always @(*) begin
    z = (state == E || state == F) ? 1'b1 : 1'b0;
end

endmodule
