module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;
    end else begin
        state <= next;
    end
end

always @* begin
    case (state)
        2'b00: begin
            if (r[1]) begin
                next = 2'b01;
            end else if (r[2]) begin
                next = 2'b10;
            end else if (r[3]) begin
                next = 2'b11;
            end else begin
                next = 2'b00;
            end
        end

        2'b01: next = r[1] ? 2'b01 : 2'b00;
        2'b10: next = r[2] ? 2'b10 : 2'b00;
        2'b11: next = r[3] ? 2'b11 : 2'b00;
    endcase
end

assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0;
assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0;
assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
