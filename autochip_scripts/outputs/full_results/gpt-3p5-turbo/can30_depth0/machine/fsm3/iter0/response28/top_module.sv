module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // State A
        else begin
            case (state)
                2'b00: begin // State A
                    if (in)
                        state <= 2'b01; // State B
                    else
                        state <= 2'b00; // State A
                end
                2'b01: begin // State B
                    if (in)
                        state <= 2'b01; // State B
                    else
                        state <= 2'b10; // State C
                end
                2'b10: begin // State C
                    if (in)
                        state <= 2'b11; // State D
                    else
                        state <= 2'b00; // State A
                end
                2'b11: begin // State D
                    if (in)
                        state <= 2'b01; // State B
                    else
                        state <= 2'b10; // State C
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (state == 2'b11) // State D
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
