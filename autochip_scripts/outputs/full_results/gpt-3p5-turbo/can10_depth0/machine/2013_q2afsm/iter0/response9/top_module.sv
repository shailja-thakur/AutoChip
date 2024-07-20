module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        2'b00: begin
            if (r[0]) begin
                next_state = 2'b01;
            end else if (r[1]) begin
                next_state = 2'b10;
            end else if (r[2]) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b01: begin
            if (r[0]) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b10: begin
            if (r[1]) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b11: begin
            if (r[2]) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        2'b01: begin
            g[0] = 1'b0;
            g[1] = 1'b1;
            g[2] = 1'b0;
        end
        2'b10: begin
            g[0] = 1'b0;
            g[1] = 1'b0;
            g[2] = 1'b1;
        end
        2'b11: begin
            g[0] = 1'b0;
            g[1] = 1'b0;
            g[2] = 1'b0;
            g[3] = 1'b1;
        end
        default: begin
            g[0] = 1'b0;
            g[1] = 1'b0;
            g[2] = 1'b0;
            g[3] = 1'b0;
        end
    endcase
end

endmodule
