module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 3'b001; // setting state to A
    end else begin
        state <= next; // updating state with next state
    end
end

always @* begin
    case (state)
        3'b001: begin // current state is A
            if (r[1]) begin
                next <= 3'b010; // next state is B
            end else if (r[2]) begin
                next <= 3'b011; // next state is C
            end else if (r[3]) begin
                next <= 3'b100; // next state is D
            end else begin
                next <= 3'b001; // next state is A
            end
        end
        3'b010: begin // current state is B
            if (r[1]) begin
                next <= 3'b010; // next state is B
            end else begin
                next <= 3'b001; // next state is A
            end
        end
        3'b011: begin // current state is C
            if (r[2]) begin
                next <= 3'b011; // next state is C
            end else begin
                next <= 3'b001; // next state is A
            end
        end
        3'b100: begin // current state is D
            if (r[3]) begin
                next <= 3'b100; // next state is D
            end else begin
                next <= 3'b001; // next state is A
            end
        end
        default: begin // default case
            next <= 3'b001; // next state is A
        end
    endcase
end

assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // g[1] is high if current state is B
assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // g[2] is high if current state is C
assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // g[3] is high if current state is D

endmodule
