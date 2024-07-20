module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [1:0] state;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
            state <= 2'b00; // Reset state
        end
        else begin
            case (state)
                2'b00: begin // Idle state
                    if (ena == 2'b01) // Left shift
                        state <= 2'b01;
                    else if (ena == 2'b10) // Right shift
                        state <= 2'b10;
                end
                2'b01: begin // Left shift state
                    q <= {q[98:0], 1'b0};
                    state <= 2'b00; // Return to idle state
                end
                2'b10: begin // Right shift state
                    q <= {1'b0, q[99:1]};
                    state <= 2'b00; // Return to idle state
                end
            endcase
        end
    end

endmodule
