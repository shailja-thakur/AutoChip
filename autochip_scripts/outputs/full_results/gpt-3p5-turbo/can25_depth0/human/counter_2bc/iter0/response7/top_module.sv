module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    reg [1:0] counter;

    // Asynchronous reset 
    always_ff @(posedge areset)
    begin
        counter <= 2'b01;
    end
    
    // Saturating counter logic
    always_ff @(posedge clk)
    begin
        if (train_valid)
        begin
            if (train_taken && (counter < 2'b11))
                counter <= counter + 2'b01;
            else if (!train_taken && (counter > 2'b00))
                counter <= counter - 2'b01;
        end
    end
    
    // Assign the output
    assign state = counter;

endmodule
