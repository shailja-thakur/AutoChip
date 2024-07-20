module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // State A
        end
        else begin
            case (state)
                2'b00: // State A
                    if (in) begin
                        state <= 2'b01; // State B
                    end
                    else begin
                        state <= 2'b00; // State A
                    end
                2'b01: // State B
                    if (in) begin
                        state <= 2'b01; // State B
                    end
                    else begin
                        state <= 2'b10; // State C
                    end
                2'b10: // State C
                    if (in) begin
                        state <= 2'b11; // State D
                    end
                    else begin
                        state <= 2'b00; // State A
                    end
                2'b11: // State D
                    if (in) begin
                        state <= 2'b01; // State B
                    end
                    else begin
                        state <= 2'b10; // State C
                    end
            endcase
        end
    end
    
    always @(*) begin
        out = (state == 2'b11); // Output is high when in State D
    end
endmodule
