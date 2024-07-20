module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_temp; // Declare q_temp outside always block

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q_temp <= q; // Assign value to q_temp

            for (integer i = 0; i < 256; i = i + 1) begin
                integer sum = 0;

                // Check neighbors...
                // Update cell state...
        
                    // Bottom-right
                    if ((i + 1) % 16 != 0 && i < 240) begin
                        sum = sum + q_temp[i + 17];
                    end else begin
                        sum = sum + q_temp[i + 1];
                    end
                end
                
                // Update cell state
                case(sum)
                    2: q[i] <= q_temp[i];
                    3: q[i] <= 1;
                    default: q[i] <= 0;
                endcase
            end
        end
    end

endmodule
