module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    reg [2:0] state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            3'b000: begin
                if (x == 1'b0)
                    next_state = 3'b000;
                else
                    next_state = 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                if (x == 1'b0)
                    next_state = 3'b001;
                else
                    next_state = 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                if (x == 1'b0)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                if (x == 1'b0)
                    next_state = 3'b001;
                else
                    next_state = 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                if (x == 1'b0)
                    next_state = 3'b011;
                else
                    next_state = 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000;
                z = 1'b0;
            end
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end
endmodule
