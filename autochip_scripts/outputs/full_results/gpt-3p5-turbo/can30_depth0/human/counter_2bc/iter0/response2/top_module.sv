module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01; // Reset to weakly not-taken
        else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11)
                    counter <= counter + 1; // Increment the counter
            end
            else begin
                if (counter > 2'b00)
                    counter <= counter - 1; // Decrement the counter
            end
        end
    end
    
    assign state = counter;
    
endmodule
