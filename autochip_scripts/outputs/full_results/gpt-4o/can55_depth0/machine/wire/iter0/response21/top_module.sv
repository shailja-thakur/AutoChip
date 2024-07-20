module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // State encoding
    localparam IDLE = 2'b00, 
               WAIT = 2'b01, 
               PROCESS = 2'b10, 
               DONE = 2'b11;
    
    // Synchronize the logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == 8'd100) begin
                        state <= PROCESS;
                    end else begin
                        state <= WAIT;
                    end
                end
                
                PROCESS: begin
                    data_out <= counter;  // Assuming some data processing based on the counter
                    state <= DONE;
                end
                
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
