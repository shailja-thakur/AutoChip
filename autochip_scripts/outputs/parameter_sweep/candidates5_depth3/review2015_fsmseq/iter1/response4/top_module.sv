module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg previous_bit;
    reg [2:0] mismatch_counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
            mismatch_counter <= 0;
        end else begin
            case(state)
                0: begin
                    if (data == 1'b1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data == 1'b1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data == 1'b0) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data == 1'b1) begin
                        start_shifting <= 1;
                        state <= 4;
                    end else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (data == 1'b1) begin
                        state <= 4;
                    end else if (data == 1'b0) begin
                        state <= 0;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            mismatch_counter <= 0;
        end else begin
            if (state == 4 && mismatch_counter < 3) begin
                if (data != (previous_bit == 1'b1 ? 1'b0 : 1'b1)) begin
                    mismatch_counter <= mismatch_counter + 1;
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            previous_bit <= 0;
        end else begin
            previous_bit <= data;
        end
    end

endmodule
