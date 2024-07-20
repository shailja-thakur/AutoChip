module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
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
                    else if (r[1] & ~r[2] & ~r[3])
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
    
    always @(state) begin
        case (state)
            3'b001: begin
                g[1] <= 1;
                g[2] <= 0;
                g[3] <= 0;
            end
            3'b010: begin
                g[1] <= 0;
                g[2] <= 1;
                g[3] <= 0;
            end
            3'b011: begin
                g[1] <= 0;
                g[2] <= 0;
                g[3] <= 1;
            end
            default: begin
                g[1] <= 0;
                g[2] <= 0;
                g[3] <= 0;
            end
        endcase
    end
    
endmodule
