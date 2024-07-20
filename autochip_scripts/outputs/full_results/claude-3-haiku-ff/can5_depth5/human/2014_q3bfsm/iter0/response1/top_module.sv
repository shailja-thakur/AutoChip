module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// State variables
reg [2:0] present_state, next_state;

// State transition logic
always @(posedge clk, posedge reset) begin
    if (reset)
        present_state <= 3'b000;
    else
        present_state <= next_state;
end

always @(*) begin
    case (present_state)
        3'b000: begin
            if (x == 0)
                next_state = 3'b000;
            else
                next_state = 3'b001;
            z = 0;
        end
        3'b001: begin
            if (x == 0)
                next_state = 3'b001;
            else
                next_state = 3'b100;
            z = 0;
        end
        3'b010: begin
            if (x == 0)
                next_state = 3'b010;
            else
                next_state = 3'b001;
            z = 0;
        end
        3'b011: begin
            if (x == 0)
                next_state = 3'b001;
            else
                next_state = 3'b010;
            z = 1;
        end
        3'b100: begin
            if (x == 0)
                next_state = 3'b011;
            else
                next_state = 3'b100;
            z = 1;
        end
        default: begin
            next_state = 3'b000;
            z = 0;
        end
    endcase
end

endmodule
