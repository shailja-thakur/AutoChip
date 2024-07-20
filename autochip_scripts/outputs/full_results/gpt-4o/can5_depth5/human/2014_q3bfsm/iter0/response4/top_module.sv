module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State transition on rising edge of clock or synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            3'b000: begin
                if (x) next_state = 3'b001;
                else next_state = 3'b000;
                z = 0;
            end
            3'b001: begin
                if (x) next_state = 3'b100;
                else next_state = 3'b001;
                z = 0;
            end
            3'b010: begin
                if (x) next_state = 3'b001;
                else next_state = 3'b010;
                z = 0;
            end
            3'b011: begin
                if (x) next_state = 3'b010;
                else next_state = 3'b001;
                z = 1;
            end
            3'b100: begin
                if (x) next_state = 3'b100;
                else next_state = 3'b011;
                z = 1;
            end
            default: begin
                next_state = 3'b000;
                z = 0;
            end
        endcase
    end
endmodule
