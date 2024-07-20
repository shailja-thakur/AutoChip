module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always@(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;  // initialize state to A
    end else begin
        state <= next; // update state with the next state
    end
end

always@(state, r) begin
    case (state)
        2'b00: begin // state A
            case(r)
                3'b100: next = 2'b10; // next state is B if r[2] is high
                3'b010: next = 2'b01; // next state is C if r[1] is high
                3'b001: next = 2'b11; // next state is D if r[0] is high
                default: next = 2'b00; // next state is A if no bits of r are high
            endcase
        end

        2'b01: begin // state B
            if (r[2]) begin
                next = 2'b01; // next state is B if r[2] is high
            end else begin
                next = 2'b00; // next state is A if r[2] is low
            end
        end

        2'b10: begin // state C
            if (r[1]) begin
                next = 2'b10; // next state is C if r[1] is high
            end else begin
                next = 2'b00; // next state is A if r[1] is low
            end
        end

        2'b11: begin // state D
            if (r[0]) begin
                next = 2'b11; // next state is D if r[0] is high
            end else begin
                next = 2'b00; // next state is A if r[0] is low
            end
        end
    endcase
end

assign g[2] = (state == 2'b01); // g[2] is high if current state is B
assign g[1] = (state == 2'b10); // g[1] is high if current state is C
assign g[0] = (state == 2'b11); // g[0] is high if current state is D
endmodule
