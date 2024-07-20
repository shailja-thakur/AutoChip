module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    // State encoding
    localparam [1:0] S0 = 2'b00, 
                     S1 = 2'b01, 
                     S2 = 2'b10, 
                     S3 = 2'b11;
    
    // Sequential block
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S1; // Asynchronous reset sets the state to S1
        else if (train_valid) begin
            // State transitions based on train_taken signal
            case (state)
                S0: state <= (train_taken) ? S1 : S0;
                S1: state <= (train_taken) ? S2 : S0;
                S2: state <= (train_taken) ? S3 : S1;
                S3: state <= (train_taken) ? S3 : S2;
                default: state <= S1; // Default state in case of unexpected state value
            endcase
        end
    end

endmodule
