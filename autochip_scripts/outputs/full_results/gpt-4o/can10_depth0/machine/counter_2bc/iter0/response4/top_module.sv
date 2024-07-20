module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    // State machine states
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S1; // Reset state
        else if (train_valid) begin
            case (state)
                S0: if (train_taken) state <= S1;
                S1: if (train_taken) state <= S2; else state <= S0;
                S2: if (train_taken) state <= S3; else state <= S1;
                S3: if (~train_taken) state <= S2;
                default: state <= S1; // Default reset state
            endcase
        end
    end
endmodule
