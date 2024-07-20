module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Declare internal signal
    logic [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01;  // Asynchronous reset
        else if (train_valid) begin
            if (train_taken & counter < 2'b11)
                counter <= counter + 1;  // Increment when train_valid = 1 and train_taken = 1
            else if (!train_taken & counter > 2'b00)
                counter <= counter - 1;  // Decrement when train_valid = 1 and train_taken = 0
        end
    end

    assign state = counter;
    
endmodule
