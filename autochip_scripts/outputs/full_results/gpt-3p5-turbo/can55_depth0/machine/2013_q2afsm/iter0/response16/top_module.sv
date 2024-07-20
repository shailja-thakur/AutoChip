module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state; // register to store the current state
reg [1:0] next; // register to store the next state

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // reset state to A
    end else begin
        state <= next; // update state with next state
    end
end

always @(state or r) begin
    case (state)
        2'b00: begin // if current state is A
            case(r)
                3'b001: next = 2'b01; // if r[1] is high, next state is B
                3'b010: next = 2'b10; // if r[2] is high, next state is C
                3'b100: next = 2'b11; // if r[3] is high, next state is D
                default: next = 2'b00; // if none of the bits of r are high, next state is A
            endcase
        end
        2'b01: begin // if current state is B
            if (r[0]) // if r[1] is high
                next = 2'b01; // next state is B
            else
                next = 2'b00; // next state is A
        end
        2'b10: begin // if current state is C
            if (r[1]) // if r[2] is high
                next = 2'b10; // next state is C
            else
                next = 2'b00; // next state is A
        end
        2'b11: begin // if current state is D
            if (r[2]) // if r[3] is high
                next = 2'b11; // next state is D
            else
                next = 2'b00; // next state is A
        end
    endcase
end

always @(state) begin
    case (state)
        2'b01: g[0] = 1'b1; // if current state is B
        2'b10: g[1] = 1'b1; // if current state is C
        2'b11: g[2] = 1'b1; // if current state is D
        default: g = 3'b000; // all other states, all bits of g are low
    endcase
end

endmodule
