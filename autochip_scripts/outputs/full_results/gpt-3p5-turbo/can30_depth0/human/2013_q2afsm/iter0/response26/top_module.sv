module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    
    reg [3:0] state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= 4'b0000;
        end else begin
            case (state)
                4'b0000: begin // State A
                    if (r[1] && !r[2] && !r[3]) begin
                        state <= 4'b0000; // Stay in A
                    end else if (r[1]) begin
                        state <= 4'b0010; // Transition to B
                    end else if (!r[1] && r[2]) begin
                        state <= 4'b0100; // Transition to C
                    end else if (!r[1] && !r[2] && !r[3]) begin
                        state <= 4'b1000; // Transition to D
                    end
                end

                4'b0010: begin // State B
                    if (g[1] && r[1]) begin
                        state <= 4'b0010; // Stay in B
                    end else if (g[1] && !r[1]) begin
                        state <= 4'b0000; // Transition to A
                    end
                end

                4'b0100: begin // State C
                    if (g[2] && r[2]) begin
                        state <= 4'b0100; // Stay in C
                    end else if (g[2] && !r[2]) begin
                        state <= 4'b0000; // Transition to A
                    end
                end

                4'b1000: begin // State D
                    state <= 4'b0000; // Transition to A
                end
            endcase
        end
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            g <= 3'b000;
        end else begin
            case (state)
                4'b0000: begin // State A
                    if (r[1] && !r[2] && !r[3]) begin
                        g <= 3'b000; // No grants
                    end else if (r[1]) begin
                        g <= 3'b001; // Grant for device 1
                    end else if (!r[1] && r[2]) begin
                        g <= 3'b010; // Grant for device 2
                    end else if (!r[1] && !r[2] && !r[3]) begin
                        g <= 3'b100; // Grant for device 3
                    end
                end

                4'b0010: begin // State B
                    if (g[1] && r[1]) begin
                        g <= 3'b001; // Grant for device 1
                    end else begin
                        g <= 3'b000; // No grants
                    end
                end

                4'b0100: begin // State C
                    if (g[2] && r[2]) begin
                        g <= 3'b010; // Grant for device 2
                    end else begin
                        g <= 3'b000; // No grants
                    end
                end

                4'b1000: begin // State D
                    g <= 3'b100; // Grant for device 3
                end
            endcase
        end
    end
endmodule
