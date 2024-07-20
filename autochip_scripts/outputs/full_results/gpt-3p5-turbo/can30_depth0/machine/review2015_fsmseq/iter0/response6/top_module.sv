module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state;
    reg start_shifting;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            start_shifting <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // State S
                    if (data == 1'b1) begin
                        state <= 3'b001; // Next state S1
                    end else begin
                        state <= 3'b000; // Next state S
                    end
                    start_shifting <= 1'b0; // Output is low
                end
                
                3'b001: begin // State S1
                    if (data == 1'b1) begin
                        state <= 3'b011; // Next state S11
                    end else begin
                        state <= 3'b000; // Next state S
                    end
                    start_shifting <= 1'b0; // Output is low
                end
                
                3'b011: begin // State S11
                    if (data == 1'b1) begin
                        state <= 3'b011; // Next state S11
                    end else begin
                        state <= 3'b110; // Next state S110
                    end
                    start_shifting <= 1'b0; // Output is low
                end
                
                3'b110: begin // State S110
                    if (data == 1'b1) begin
                        state <= 3'b111; // Next state Done
                    end else begin
                        state <= 3'b000; // Next state S
                    end
                    start_shifting <= 1'b0; // Output is low
                end
                
                3'b111: begin // State Done
                    state <= 3'b111; // Next state Done
                    start_shifting <= 1'b1; // Output is high
                end
            endcase
        end
    end
    
endmodule
