module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // BYTE1
        end else begin
            case (state)
                2'b00: begin // BYTE1
                    if (in[2] == 1'b1) begin
                        state <= 2'b01; // BYTE2
                    end
                end
                2'b01: state <= 2'b10; // BYTE2
                2'b10: state <= 2'b11; // BYTE3
                2'b11: begin // DONE
                    if (in[2] == 1'b0) begin
                        state <= 2'b00; // BYTE1
                    end else begin
                        state <= 2'b01; // BYTE2
                    end
                end
            endcase
        end
    end
    
    assign done = (state == 2'b11) ? 1'b1 : 1'b0;
  
endmodule
