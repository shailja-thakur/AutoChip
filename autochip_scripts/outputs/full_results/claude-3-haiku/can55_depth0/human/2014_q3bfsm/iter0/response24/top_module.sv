module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

// State transitions
always @(*) begin
    case (state)
        3'b000: begin
            if (x == 1'b0)
                next_state = 3'b001;
            else
                next_state = 3'b001;
        end
        3'b001: begin
            if (x == 1'b0)
                next_state = 3'b001;
            else
                next_state = 3'b100;
        end
        3'b010: begin
            if (x == 1'b0)
                next_state = 3'b001;
            else
                next_state = 3'b001;
        end
        3'b011: begin
            if (x == 1'b0)
                next_state = 3'b001;
            else
                next_state = 3'b010;
        end
        3'b100: begin
            if (x == 1'b0)
                next_state = 3'b011;
            else
                next_state = 3'b100;
        end
        default: next_state = 3'b000;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        3'b011, 3'b100: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

endmodule
