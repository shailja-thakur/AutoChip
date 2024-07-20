module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000; // Initial state (S)
        end else begin
            state <= next_state;
        end
    end
    
    always @(state, data) begin
        case (state)
            4'b0000: begin // State S
                if (data) begin
                    next_state = 4'b0001; // Next state S1
                end else begin
                    next_state = 4'b0000; // Next state S
                end
            end
            4'b0001: begin // State S1
                if (data) begin
                    next_state = 4'b0011; // Next state S11
                end else begin
                    next_state = 4'b0000; // Next state S
                end
            end
            4'b0011: begin // State S11
                if (data) begin
                    next_state = 4'b0011; // Next state S11
                end else begin
                    next_state = 4'b0110; // Next state S110
                end
            end
            4'b0110: begin // State S110
                if (data) begin
                    next_state = 4'b1111; // Next state Done
                end else begin
                    next_state = 4'b0000; // Next state S
                end
            end
            4'b1111: begin // State Done
                next_state = 4'b1111; // Next state Done
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 1'b0; // Reset the output to low
        end else begin
            start_shifting <= (state == 4'b1111) ? 1'b1 : 1'b0; // Set output to high if in Done state
        end
    end

endmodule
