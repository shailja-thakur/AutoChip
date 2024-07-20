module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define the states
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE = 2'b11;
    
    // Declare state and next_state variables
    reg [1:0] state, next_state;
    
    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end
    
    // Check the third bit of the input in BYTE1 state
    always @(posedge clk) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state <= BYTE2;
                end else begin
                    next_state <= BYTE1;
                end
            end
            BYTE2: begin
                next_state <= BYTE3;
            end
            BYTE3: begin
                next_state <= DONE;
            end
            DONE: begin
                if (in[2] == 1'b1) begin
                    next_state <= BYTE2;
                end else begin
                    next_state <= BYTE1;
                end
            end
        endcase
    end
    
    // Output done signal
    assign done = (state == DONE);
    
endmodule
