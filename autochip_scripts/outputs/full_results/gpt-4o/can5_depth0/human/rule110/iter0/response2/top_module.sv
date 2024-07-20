module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            // Load initial state
            q <= data;
        end else begin
            // Array to store next state
            reg [511:0] next_q;
            
            // Compute next state based on Rule 110
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Left boundary (q[-1] is considered 0)
                    next_q[i] = (q[i + 1] == 1) ? 1'b1 : 1'b0;
                end else if (i == 511) begin
                    // Right boundary (q[512] is considered 0)
                    next_q[i] = (q[i - 1] == 1) ? 1'b1 : 1'b0;
                end else begin
                    // Inner cells
                    case ({q[i + 1], q[i], q[i - 1]})
                        3'b111: next_q[i] = 1'b0;
                        3'b110: next_q[i] = 1'b1;
                        3'b101: next_q[i] = 1'b1;
                        3'b100: next_q[i] = 1'b0;
                        3'b011: next_q[i] = 1'b1;
                        3'b010: next_q[i] = 1'b1;
                        3'b001: next_q[i] = 1'b1;
                        3'b000: next_q[i] = 1'b0;
                        default: next_q[i] = 1'b0;
                    endcase
                end
            end
            
            // Update the state
            q <= next_q;
        end
    end
endmodule
