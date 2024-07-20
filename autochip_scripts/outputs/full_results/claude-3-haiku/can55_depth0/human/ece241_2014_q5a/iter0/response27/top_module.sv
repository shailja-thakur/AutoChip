module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] sum;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 8'b0;
        sum <= 8'b0;
        state <= 1'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            1'b0: begin // Reset state
                if (!areset) begin
                    state <= 1'b1; // Move to compute state
                end
            end
            1'b1: begin // Compute state
                if (counter == 8'd7) begin
                    z <= ~sum + 1'b1; // Output 2's complement
                    counter <= 8'b0;
                    state <= 1'b0; // Return to reset state
                end
                else begin
                    sum <= (sum >> 1) | (x << 7); // Shift in new bit
                    counter <= counter + 1'b1;
                end
            end
        endcase
    end
end

endmodule
