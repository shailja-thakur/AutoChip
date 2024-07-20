module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= 2'b0;
        end else begin
            case (state)
                2'b0: begin // State A
                    if (j == 1'b1) begin
                        state <= 2'b1; // Next state is B
                    end else begin
                        state <= 2'b0; // Next state remains A
                    end
                end
                2'b1: begin // State B
                    if (k == 1'b1) begin
                        state <= 2'b0; // Next state is A
                    end else begin
                        state <= 2'b1; // Next state remains B
                    end
                end
                default: state <= 2'b0;
            endcase
        end
    end
    
    assign out = (state == 2'b1) ? 1'b1 : 1'b0; // Output is high when state is B, low when state is A
    
endmodule
