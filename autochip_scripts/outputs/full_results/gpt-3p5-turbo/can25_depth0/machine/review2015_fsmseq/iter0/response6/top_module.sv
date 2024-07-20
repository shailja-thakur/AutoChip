module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case(state)
                3'b000: begin
                    if (data) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    if (data) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin
                    if (data) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b110;
                    end
                end
                3'b110: begin
                    if (data) begin
                        state <= 3'b111;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b111: begin
                    state <= 3'b111;
                end
                default: state <= 3'b000;
            endcase
        end
    end
    
    assign start_shifting = (state == 3'b111);

endmodule
