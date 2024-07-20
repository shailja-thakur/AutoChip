module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

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
            if (r[1]) begin
                next_state = 2'b01;
            end else if (r[2]) begin
                next_state = 2'b10;
            end else if (r[3]) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b01: begin
            if (r[1]) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b10: begin
            if (r[2]) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b11: begin
            if (r[3]) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
    endcase
end

assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0;
assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0;
assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0;
endmodule
