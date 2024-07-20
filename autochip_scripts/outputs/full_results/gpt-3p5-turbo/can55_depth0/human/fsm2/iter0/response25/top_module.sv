module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0;  // Reset to state OFF
        end else begin
            case(state)
                2'b00: begin  // OFF (out=0)
                    if (j) begin
                        state <= 2'b01;  // Transition to state ON
                        out <= 1'b0;
                    end
                end

                2'b01: begin  // ON (out=1)
                    if (k) begin
                        state <= 2'b00;  // Transition to state OFF
                        out <= 1'b1;
                    end
                end
            endcase
        end
    end
endmodule
