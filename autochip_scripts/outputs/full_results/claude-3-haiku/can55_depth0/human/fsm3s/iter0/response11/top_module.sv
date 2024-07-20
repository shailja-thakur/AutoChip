module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State encoding
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (in == 0) next_state = A;
            else next_state = B;
            out = 0;
        end
        B: begin
            if (in == 0) next_state = C;
            else next_state = B;
            out = 0;
        end
        C: begin
            if (in == 0) next_state = A;
            else next_state = D;
            out = 0;
        end
        D: begin
            if (in == 0) next_state = C;
            else next_state = B;
            out = 1;
        end
    endcase
end

// State register
always @(posedge clk or posedge reset) begin
    if (reset) state <= A;
    else state <= next_state;
end

endmodule
