module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);
    reg [1:0] state, next_state;
    reg reset_sync;

    always @(posedge clk) begin
        if (resetn == 0) begin
            reset_sync <= 1'b0;
        end
        else begin
            reset_sync <= 1'b1;
        end
    end

    always @(posedge clk) begin
        if (reset_sync) begin
            state <= 2'b00;
        end
        else begin
            state <= next_state;
        end
    end

    always @(state, r) begin
        case (state)
            2'b00: begin
                if (r[0]) begin
                    next_state = 2'b01;
                end
                else if (r[1]) begin
                    next_state = 2'b10;
                end
                else if (r[2]) begin
                    next_state = 2'b11;
                end
                else begin
                    next_state = 2'b00;
                end
            end

            2'b01: begin
                if (r[0]) begin
                    next_state = 2'b01;
                end
                else begin
                    next_state = 2'b00;
                end
            end

            2'b10: begin
                if (r[1]) begin
                    next_state = 2'b10;
                end
                else begin
                    next_state = 2'b00;
                end
            end

            2'b11: begin
                if (r[2]) begin
                    next_state = 2'b11;
                end
                else begin
                    next_state = 2'b00;
                end
            end

            default: begin
                next_state = 2'b00;
            end
        endcase
    end

    assign g[0] = (state == 2'b01) ? 1'b1 : 1'b0;
    assign g[1] = (state == 2'b10) ? 1'b1 : 1'b0;
    assign g[2] = (state == 2'b11) ? 1'b1 : 1'b0;
endmodule
