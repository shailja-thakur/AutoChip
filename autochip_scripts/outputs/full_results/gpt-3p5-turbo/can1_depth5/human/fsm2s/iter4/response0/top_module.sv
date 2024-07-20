module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    reg reset_reg;
    
    always @(posedge clk) begin
        reset_reg <= reset;
        
        if (reset_reg) begin
            state <= 2'b00;
            out_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // OFF state
                    if (j) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin // ON state
                    if (k) begin
                        state <= 2'b00;
                    end else begin
                        state <= 2'b01;
                    end
                end
                default: begin
                    state <= 2'b00;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            2'b00: out_reg = 1'b0;
            2'b01: out_reg = 1'b1;
            default: out_reg = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        if (reset_reg) begin
            out <= 1'b0;
        end else begin
            out <= out_reg;
        end
    end

endmodule
