module top_module (
        input clk,
        input j,
        input k,
        input areset,
        output reg out
);

    reg [1:0] state;
    reg next_state;

    // Moore state assignments
    parameter OFF = 2'b00;
    parameter ON = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    always @(state, j, k) begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

    always @(state) begin
        case (state)
            OFF: begin
                out = 1'b0;
            end
            ON: begin
                out = 1'b1;
            end
        endcase
    end

endmodule
