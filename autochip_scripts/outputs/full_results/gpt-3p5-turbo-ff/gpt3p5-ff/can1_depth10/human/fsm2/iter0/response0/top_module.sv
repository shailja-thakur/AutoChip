module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {OFF, ON} state_type;
    state_type state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            OFF: begin
                if (j == 1) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
                out = 0;
            end

            ON: begin
                if (k == 1) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
                out = 1;
            end
        endcase
    end

endmodule
