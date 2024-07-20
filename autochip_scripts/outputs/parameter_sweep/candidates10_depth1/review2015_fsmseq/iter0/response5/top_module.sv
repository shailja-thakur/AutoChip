module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
// Define states
enum {IDLE, S0, S1, S2, S3, FOUND} state, next_state;

// Define state signals
reg [1:0] state_reg;
always @(posedge clk or posedge reset) begin
    if (reset)
        state_reg <= IDLE;
    else
        state_reg <= next_state;
end

// Detect sequence 1101
always @* begin
    case (state_reg)
        IDLE: begin
            if (data) begin
                next_state = S0;
                start_shifting = 0;
            end else begin
                next_state = IDLE;
                start_shifting = 0;
            end
        end
        S0: begin
            if (data) begin
                next_state = S0;
                start_shifting = 0;
            end else begin
                next_state = S1;
                start_shifting = 0;
            end
        end
        S1: begin
            if (data) begin
                next_state = S2;
                start_shifting = 0;
            end else begin
                next_state = S1;
                start_shifting = 0;
            end
        end
        S2: begin
            if (data) begin
                next_state = S0;
                start_shifting = 0;
            end else begin
                next_state = S3;
                start_shifting = 0;
            end
        end
        S3: begin
            if (data) begin
                next_state = FOUND;
                start_shifting = 1;
            end else begin
                next_state = IDLE;
                start_shifting = 0;
            end
        end
        FOUND: begin
            next_state = IDLE;
            start_shifting = 0;
        end
    endcase
end

endmodule
