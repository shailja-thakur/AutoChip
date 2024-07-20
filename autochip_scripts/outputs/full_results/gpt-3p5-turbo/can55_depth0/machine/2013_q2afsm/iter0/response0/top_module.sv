module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00;  // set initial state to A
    end else begin
        state <= next;  // update state based on next state value
    end
end

always @(state or r) begin
    case (state)
        2'b00: begin // state A
            if (r[1]) begin
                next = 2'b01;  // next state B, if r[1] is high
            end else if (r[2]) begin
                next = 2'b10;  // next state C, if r[2] is high
            end else if (r[3]) begin
                next = 2'b11;  // next state D, if r[3] is high
            end else begin
                next = 2'b00;  // next state A
            end
        end
        2'b01: begin // state B
            if (r[1]) begin
                next = 2'b01;  // next state B, if r[1] is high
            end else begin
                next = 2'b00;  // next state A
            end
        end
        2'b10: begin // state C
            if (r[2]) begin
                next = 2'b10;  // next state C, if r[2] is high
            end else begin
                next = 2'b00;  // next state A
            end
        end
        2'b11: begin // state D
            if (r[3]) begin
                next = 2'b11;  // next state D, if r[3] is high
            end else begin
                next = 2'b00;  // next state A
            end
        end
    endcase
end

assign g[1] = (state == 2'b01);  // set g[1] high if current state is B
assign g[2] = (state == 2'b10);  // set g[2] high if current state is C
assign g[3] = (state == 2'b11);  // set g[3] high if current state is D

endmodule
