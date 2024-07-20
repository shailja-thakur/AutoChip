module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

// State assignment
always @(*) begin
    case (present_state)
        3'b000: begin
            if (x == 0) next_state = 3'b000;
            else next_state = 3'b001;
        end
        3'b001: begin
            if (x == 0) next_state = 3'b001;
            else next_state = 3'b100;
        end
        3'b010: begin
            if (x == 0) next_state = 3'b010;
            else next_state = 3'b001;
        end
        3'b011: begin
            if (x == 0) next_state = 3'b001;
            else next_state = 3'b010;
        end
        3'b100: begin
            if (x == 0) next_state = 3'b011;
            else next_state = 3'b100;
        end
        default: next_state = 3'b000;
    endcase
end

// Output logic
always @(*) begin
    case (present_state)
        3'b000, 3'b001, 3'b010: z = 0;
        3'b011, 3'b100: z = 1;
        default: z = 0;
    endcase
end

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) present_state <= 3'b000;
    else present_state <= next_state;
end

endmodule
