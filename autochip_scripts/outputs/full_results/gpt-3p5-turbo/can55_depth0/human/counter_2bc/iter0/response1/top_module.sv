module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] count;

    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            count <= 2'b01; // Reset to weakly not-taken
        else if (train_valid)
        begin
            if (train_taken)
            begin
                if (count == 2'b11)
                    count <= 2'b11; // Saturate at maximum value
                else
                    count <= count + 1; // Increment counter
            end
            else
            begin
                if (count == 2'b00)
                    count <= 2'b00; // Saturate at minimum value
                else
                    count <= count - 1; // Decrement counter
            end
        end
    end

    assign state = count;

endmodule
