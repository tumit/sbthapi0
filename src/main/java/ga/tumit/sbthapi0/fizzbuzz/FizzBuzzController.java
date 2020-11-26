package ga.tumit.sbthapi0.fizzbuzz;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/fizzbuzz/")
public class FizzBuzzController {

    @GetMapping("/say/{number}")
    public String say(
            @PathVariable int number
    ) {
        return String.valueOf(number);
    }

}
