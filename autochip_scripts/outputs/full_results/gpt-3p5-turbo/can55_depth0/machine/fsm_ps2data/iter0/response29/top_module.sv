module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    
    reg [23:0] register;
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            register <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (in[2] == 1'b1) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                    register <= {register[15:0], in};
                end
                2'b01: begin
                    state <= 2'b10;
                    register <= {register[15:0], in};
                end
                2'b10: begin
                    if (in[2] == 1'b1) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b00;
                    end
                    register <= {register[15:0], in};
                end
                2'b11: begin
                    state <= 2'b00;
                    done <= 1'b1;
                    register <= {register[15:0], in};
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    assign out_bytes = done ? register : 0;
    
endmodule
