module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // Initial state A
    end else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        2'b00: begin // State A
            if (r[2]) begin
                next_state = 2'b10; // Next state C
            end else if (r[1]) begin
                next_state = 2'b01; // Next state B
            end else if (r[0]) begin
                next_state = 2'b11; // Next state D
            end else begin
                next_state = 2'b00; // Next state A
            end
        end
        2'b01: begin // State B
            if (r[1]) begin
                next_state = 2'b01; // Next state B
            end else begin
                next_state = 2'b00; // Next state A
            end
        end
        2'b10: begin // State C
            if (r[2]) begin
                next_state = 2'b10; // Next state C
            end else begin
                next_state = 2'b00; // Next state A
            end
        end
        2'b11: begin // State D
            if (r[0]) begin
                next_state = 2'b11; // Next state D
            end else begin
                next_state = 2'b00; // Next state A
            end
        end
    endcase
end

always @* begin
    case(state)
        2'b01: begin // State B
            g[2] = 1'b1;
        end
        2'b10: begin // State C
            g[1] = 1'b1;
        end
        2'b11: begin // State D
            g[0] = 1'b1;
        end
        default: begin
            g[2:0] = 3'b0;
        end
    endcase
end

endmodule
