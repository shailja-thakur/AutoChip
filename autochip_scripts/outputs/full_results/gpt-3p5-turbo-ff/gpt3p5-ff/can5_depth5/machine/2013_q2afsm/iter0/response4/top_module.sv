module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (~resetn) begin
        state <= 2'b00; // set state to A
    end else begin
        state <= next;
    end
end

always @(state or r) begin
    case (state)
        2'b00: begin // state A
            case (r)
                3'b001: next = 2'b01; // r[1] is high, next state is B
                3'b010: next = 2'b10; // r[2] is high, next state is C
                3'b100: next = 2'b11; // r[3] is high, next state is D
                default: next = 2'b00; // none of the bits are high, next state is A
            endcase
        end
        2'b01: begin // state B
            if (r[1]) begin // r[1] is high
                next = 2'b01; // next state is B
            end else begin
                next = 2'b00; // next state is A
            end
        end
        2'b10: begin // state C
            if (r[2]) begin // r[2] is high
                next = 2'b10; // next state is C
            end else begin
                next = 2'b00; // next state is A
            end
        end
        2'b11: begin // state D
            if (r[3]) begin // r[3] is high
                next = 2'b11; // next state is D
            end else begin
                next = 2'b00; // next state is A
            end
        end
        default: next = 2'b00;
    endcase
end

always @(state) begin
    case (state)
        2'b01: g[2] = 1'b1; // g[1] is high when state is B
        2'b10: g[1] = 1'b1; // g[2] is high when state is C
        2'b11: g[0] = 1'b1; // g[3] is high when state is D
        default: g = 3'b000; // all bits of g are low for other states
    endcase
end

endmodule
