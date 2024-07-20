module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

    reg [1:0] state;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [3:0] shift_register;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            shift_register <= 4'b0000;
        end else begin
            case (state)
                S0: begin
                    if (data) begin
                        state <= S1;
                        shift_register <= {shift_register[2:0], data};
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S2;
                        shift_register <= {shift_register[2:0], data};
                    end else begin
                        state <= S0;
                        shift_register <= 4'b0000;
                    end
                end
                S2: begin
                    if (data) begin
                        state <= S3;
                        shift_register <= {shift_register[2:0], data};
                    end else begin
                        state <= S0;
                        shift_register <= 4'b0000;
                    end
                end
                S3: begin
                    if (!data) begin
                        state <= S0;
                        shift_register <= 4'b0000;
                    end else begin
                        state <= S3;
                        shift_register <= {shift_register[2:0], data};
                    end
                end
            endcase
        end
    end
    
    assign start_shifting = (state == S3);
    
endmodule
