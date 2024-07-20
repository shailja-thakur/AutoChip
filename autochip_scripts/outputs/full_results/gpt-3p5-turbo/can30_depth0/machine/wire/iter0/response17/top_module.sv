module top_module(
    input wire clk,
    input wire reset,
    output wire data,
    output wire valid
);

reg [1:0] state;
reg [7:0] counter;
reg [7:0] data_output;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Set initial state to idle
        counter <= 8'b0; // Reset counter
        data_output <= 8'b0; // Set data output to 0
        valid <= 1'b0; // Set valid output to 0
    end else begin
        case (state)
            2'b00: begin // Idle state
                counter <= 8'b0; // Reset counter
                data_output <= 8'b0; // Set data output to 0
                valid <= 1'b0; // Set valid output to 0
                
                if (in) begin // If input signal is asserted
                    state <= 2'b01; // Transition to wait state
                end
            end
            
            2'b01: begin // Wait state
                if (counter == 8'd255) begin // If counter reaches threshold
                    state <= 2'b10; // Transition to process state
                end else begin
                    counter <= counter + 1; // Increment counter
                end
                data_output <= 8'b0; // Set data output to 0
                valid <= 1'b0; // Set valid output to 0
            end
            
            2'b10: begin // Process state
                data_output <= in; // Set data output to input signal
                state <= 2'b11; // Transition to done state
            end
            
            2'b11: begin // Done state
                valid <= 1'b1; // Set valid output to 1
                state <= 2'b00; // Transition back to idle state
            end
        endcase
    end
end

assign out = data_output;

endmodule
