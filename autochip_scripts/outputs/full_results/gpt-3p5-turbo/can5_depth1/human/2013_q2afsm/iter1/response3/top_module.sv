module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin // A state
                    if (r[1] & ~r[2] & ~r[3])
                        state <= 3'b000;
                    else if (~r[1] & ~r[2] & r[3])
                        state <= 3'b001;
                    else if (~r[1] & r[2] & ~r[3])
                        state <= 3'b010;
                    else if (~r[1] & ~r[2] & ~r[3])
                        state <= 3'b011;
                end
                3'b001: begin // B state
                    if (r[1] & g[1])
                        state <= 3'b001;
                    else if (~r[1] & g[1])
                        state <= 3'b000;
                end
                3'b010: begin // C state
                    if (r[2] & g[2])
                        state <= 3'b010;
                    else if (~r[2] & g[2])
                        state <= 3'b000;
                end
                3'b011: begin // D state
                    state <= 3'b000;
                end
            endcase
        end
    end
    
    assign g[1] = (state == 3'b001) ? 1'b1 : 1'b0;
    assign g[2] = (state == 3'b010) ? 1'b1 : 1'b0;
    assign g[3] = (state == 3'b011) ? 1'b1 : 1'b0;
    
endmodule
