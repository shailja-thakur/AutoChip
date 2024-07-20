module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define the state variables using one-hot encoding
reg A, B;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        // Reset to state A
        A <= 1'b1;
        B <= 1'b0;
    end
    else begin
        case ({A, B})
            2'b10: begin // State A
                if (x == 1'b0) begin
                    A <= 1'b1;
                    B <= 1'b0;
                    z <= 1'b0;
                end
                else begin
                    A <= 1'b0;
                    B <= 1'b1;
                    z <= 1'b1;
                end
            end
            2'b01: begin // State B
                if (x == 1'b0) begin
                    A <= 1'b0;
                    B <= 1'b1;
                    z <= 1'b1;
                end
                else begin
                    A <= 1'b0;
                    B <= 1'b1;
                    z <= 1'b0;
                end
            end
            default: begin // Handles any other cases
                A <= 1'b1;
                B <= 1'b0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
